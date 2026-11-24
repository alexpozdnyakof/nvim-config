vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

if vim.fn.has "nvim-0.12" == 1 then
  local query = vim.treesitter.query
  local opts = { force = true, all = false }

  local function get_node(match, id)
    local val = match[id]
    if not val then return nil end
    if type(val) == "table" then return val[1] end
    return val
  end

  local html_script_type_languages = {
    ["importmap"] = "json",
    ["module"] = "javascript",
    ["application/ecmascript"] = "javascript",
    ["text/ecmascript"] = "javascript",
  }

  local non_filetype_match_injection_language_aliases = {
    ex = "elixir",
    pl = "perl",
    sh = "bash",
    uxn = "uxntal",
    ts = "typescript",
  }

  local function get_parser_from_markdown_info_string(injection_alias)
    local ft = vim.filetype.match { filename = "a." .. injection_alias }
    return ft or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
  end

  query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = get_node(match, pred[2])
    if not node then return end
    metadata["injection.language"] = get_parser_from_markdown_info_string(vim.treesitter.get_node_text(node, bufnr):lower())
  end, opts)

  query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = get_node(match, pred[2])
    if not node then return end
    local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[type_attr_value]
    if configured then
      metadata["injection.language"] = configured
    else
      local parts = vim.split(type_attr_value, "/", {})
      metadata["injection.language"] = parts[#parts]
    end
  end, opts)

  query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = get_node(match, id)
    if not node then return end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then metadata[id] = {} end
    metadata[id].text = string.lower(text)
  end, opts)

  query.add_predicate("nth?", function(match, _, _, pred)
    local node = get_node(match, pred[2])
    local n = tonumber(pred[3])
    if node and node:parent() and node:parent():named_child_count() > n then
      return node:parent():named_child(n) == node
    end
    return false
  end, opts)

  query.add_predicate("kind-eq?", function(match, _, _, pred)
    local node = get_node(match, pred[2])
    if not node then return true end
    return vim.tbl_contains({ unpack(pred, 3) }, node:type())
  end, opts)

  query.add_predicate("is?", function(match, _, bufnr, pred)
    local node = get_node(match, pred[2])
    if not node then return true end
    local _, _, kind = require("nvim-treesitter.locals").find_definition(node, bufnr)
    return vim.tbl_contains({ unpack(pred, 3) }, kind)
  end, opts)
end
