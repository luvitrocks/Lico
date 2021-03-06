local table = require('table')

local sltluv = require('sltluv')

local page_maker = require('./page-to-table')
local pages_maker = require('./read-directory')

function render(current_page, pages, config)
  local template = sltluv.loadfile(config.theme_path .. current_page.template .. ".html")
  local results = sltluv.render(template, {
      current_page = current_page,
      pages = pages,
      page_count = table.getn(pages),
      config = config
    })
  return results
end

return function(target, config)
  -- load up the template helpers
  local slt_extensions = require('slt-extensions')(config)
  local current_page = page_maker(target, true)
  local pages = pages_maker(config.content_dir)
  return render(current_page, pages, config)
end