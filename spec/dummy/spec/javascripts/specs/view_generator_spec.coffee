# assuming, that these generators are called before running spec:
#
#   Layout
#   'rails g marionette:view TestLayout1 Layout'
#   'rails g marionette:view admin/TestLayout2 Layout'
#   'rails g marionette:view TestSubsubmodule/test_submodule/TestModule/TestLayout3 Layout'
#
#   ItemView
#   'rails g marionette:view TestItemView1 ItemView title:string description:text url:text phone:string quantity:integer float_number:float decimal_number:decimal full:boolean email:string password:string'
#   'rails g marionette:view TestItemView2 ItemView'
#   'rails g marionette:view test_module/TestItemView3 ItemView'
#   'rails g marionette:view TestSubsubmodule/test_submodule/TestModule/testItemView4 ItemView'
#
#   CollectionView
#   'rails g marionette:view TestCollectionView1 CollectionView'
#   'rails g marionette:view admin/TestCollectionView2 CollectionView'
#   'rails g marionette:view TestSubsubmodule/test_submodule/TestModule/TestCollectionView3 CollectionView'
#
#   CompositeView
#   'rails g marionette:view TestCompositeView1 CompositeView'
#   'rails g marionette:view test_module/TestCompositeView2 CompositeView'
#   'rails g marionette:view TestSubsubmodule/test_submodule/TestModule/testCompositeView3 CompositeView'
#

describe 'Backbone view after generate', ->