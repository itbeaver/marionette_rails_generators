# assuming, that these generators are called before running spec:
#
#   Entity
#   'rails g marionette:model Posts title:string description:text'
#   'rails g marionette:model admin/books'
#   'rails g marionette:model TestSubsubmodule/test_submodule/TestModule/stars'
#

describe 'Backbone model after generate', ->
  it 'Entity responds', ->
    expect(Backbone.app.Entities.All.Posts).toBeDefined()
    expect(Backbone.app.Entities.Admin.Books).toBeDefined()
    expect(Backbone.app.Entities.TestSubsubmodule.TestSubmodule.TestModule.Stars).toBeDefined()
