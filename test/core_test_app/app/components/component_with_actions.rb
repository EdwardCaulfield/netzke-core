class ComponentWithActions < Netzke::Base
  action :some_action do |a|
    a.text = "Some Cool Action"
    a.icon = Netzke::Core.icons_uri + "/tick.png" # specify full icon path
  end

  action :another_action do |a|
    a.disabled = true
    a.text = "Disabled action"
    a.icon = :accept # the accept.png icon will be looked for in Netzke::Core.icons_uri
  end

  action :action_with_custom_handler do |c|
    c.text = "Action with custom handler"
    c.handler = :custom_action_handler
  end

  def configure
    super
    config.title = "Panel that has actions"
    config.bbar = [:some_action, :another_action, :action_with_custom_handler]
    config.tbar = [{
      :xtype =>  'buttongroup',
      :columns => 3,
      :title => 'A group',
      :items => [{
          :text => 'Paste',
          :scale => 'large',
          :rowspan => 3, :iconCls => 'add',
          :iconAlign => 'top',
          :cls => 'x-btn-as-arrow'
      },{
          :xtype => 'splitbutton',
          :text => 'Menu Button',
          :scale => 'large',
          :rowspan => 3,
          :iconCls => 'add',
          :iconAlign => 'top',
          :arrowAlign => 'bottom',
          :menu => [:some_action]
      },{
          :xtype => 'splitbutton', :text => 'Cut', :menu => [:another_action]
      }, :another_action,
      {
          :menu => [:some_action], :text => 'Format'
      }]
    }]
  end

  js_property :on_some_action, <<-JS.l
    function(){
      this.update("Some action was triggered");
    }
  JS

  js_method :on_another_action, <<-JS
    function(){
      this.update("Another action was triggered");
    }
  JS

  js_method :custom_action_handler, <<-JS
    function(){
      this.update("Custom action handler was called");
    }
  JS
end
