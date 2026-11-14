-- pseudocode.lua
-- Quarto filter: renders pseudocode blocks as Typst via the lovelace package
-- https://typst.app/universe/package/lovelace/

local lovelace_imported = false

local function ensure_lovelace_import()
  if not lovelace_imported then
    quarto.doc.include_text('in-header', '#import "@preview/lovelace:0.3.1": *\n')
    lovelace_imported = true
  end
end

-- Build the lovelace argument string from code block attributes.
local function build_args(attrs)
  local args = {}

  local title = attrs['title']
  if title then
    table.insert(args, 'title: [' .. title .. ']')
  end

  local ln = attrs['line-numbering']
  if ln then
    if ln == 'none' or ln == 'false' then
      table.insert(args, 'line-numbering: none')
    else
      table.insert(args, 'line-numbering: "' .. ln .. '"')
    end
  end

  local booktabs = attrs['booktabs']
  if booktabs then
    table.insert(args, 'booktabs: ' .. (booktabs == 'true' and 'true' or 'false'))
  end

  for _, key in ipairs({ 'stroke', 'hooks', 'indentation', 'line-gap',
                          'booktabs-stroke', 'title-inset',
                          'line-number-supplement', 'line-number-alignment' }) do
    local val = attrs[key]
    if val then
      table.insert(args, key .. ': ' .. val)
    end
  end

  return table.concat(args, ', ')
end

function CodeBlock(el)
  if el.classes:includes('pseudocode') then
    if quarto.doc.is_format('typst') then
      ensure_lovelace_import()

      -- Parse as markdown so Pandoc handles math, escaping, etc.
      -- *keyword* is Pandoc Emph (italic); convert to Strong (bold) since
      -- pseudocode keywords are conventionally bold and *...* is the natural
      -- pseudocode syntax for them.
      local parsed = pandoc.read(el.text, 'markdown'):walk({
        Emph = function(e) return pandoc.Strong(pandoc.Inlines(e.content)) end
      })
      local content = pandoc.write(parsed, 'typst'):gsub('%s+$', '')

      local cap = el.attributes['cap'] or el.attributes['caption']
      local id  = el.identifier
      local as_figure = cap ~= nil and cap ~= '' and id ~= nil and id ~= ''
      local args = build_args(el.attributes)

      local pl_call
      if args ~= '' then
        pl_call = 'pseudocode-list(' .. args .. ')[\n' .. content .. '\n]'
      else
        pl_call = 'pseudocode-list[\n' .. content .. '\n]'
      end

      local typst_code
      if as_figure then
        typst_code = table.concat({
          '#figure(',
          '  kind: "algorithm",',
          '  supplement: [Algorithm],',
          '  caption: [' .. cap .. '],',
          '  ' .. pl_call,
          ') <' .. id .. '>',
        }, '\n')
      else
        typst_code = '#' .. pl_call
      end

      return pandoc.RawBlock('typst', typst_code)
    end
  end
end

-- Quarto's crossref cannot see labels inside RawBlocks, so unresolved @alg-*
-- references become Strong([Str("?@label")]). Fix them to native Typst #ref(<label>).
function Strong(el)
  if quarto.doc.is_format('typst')
      and #el.content == 1
      and el.content[1].tag == 'Str' then
    local label = el.content[1].text:match('^%?@(alg%-.+)$')
    if label then
      return pandoc.RawInline('typst', '#ref(<' .. label .. '>)')
    end
  end
end
