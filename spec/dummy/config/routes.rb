require File.expand_path("../../../../lib/kazutori/engine", __FILE__)
Rails.application.routes.draw do
  mount Kazutori::Engine => "/kazutori"
end
