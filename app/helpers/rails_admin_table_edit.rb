RailsAdmin::FormBuilder.class_eval do
  def generate_for_table_edit(options = {})
    without_field_error_proc_added_div do
        options.reverse_merge!(
          action: @template.controller.params[:action],
          model_config: @template.instance_variable_get(:@model_config),
          nested_in: false,
          css_classes: [],
        )

        object_infos +
          visible_groups(options[:model_config], generator_action(options[:action], options[:nested_in])).collect do |fieldset|
            fieldset_for_table_edit fieldset, options
          end.join.html_safe +
          (options[:nested_in] ? '' : @template.render(partial: 'rails_admin/main/submit_buttons'))
      end
  end

  def fieldset_for_table_edit(fieldset, options = {})
    fields = fieldset.with(
      form: self,
      object: @object,
      view: @template,
      controller: @template.controller,
    ).visible_fields
    return if fields.empty?

    @template.content_tag :fieldset do
      contents = []
      contents << @template.content_tag(:legend, %(<i class="icon-chevron-#{(fieldset.active? ? 'down' : 'right')}"></i> #{fieldset.label}).html_safe, style: fieldset.name == :default ? 'display:none' : '')
      contents << @template.content_tag(:p, fieldset.help) if fieldset.help.present?
      contents << fields.collect { |field| field_wrapper_for_table_edit(field, options[:nested_in], options[:wrapper], options[:css_classes]) }.join
      contents.join.html_safe
    end
  end

  def field_wrapper_for_table_edit(field, nested_in, wrapper = nil, css_classes = [])
    if field.label
      # do not show nested field if the target is the origin
      unless nested_field_association?(field, nested_in)
        @template.content_tag(wrapper || :div, class: "form-group control-group #{css_classes.join(' ')} #{field.type_css_class} #{field.css_class} #{'error' if field.errors.present?}", id: "#{dom_id(field)}_field") do
          (field.nested_form ? field_for_table_view(field) : input_for_table_edit(field))
        end
      end
    else
      field.nested_form ? field_for_table_view(field) : input_for_table_edit(field)
    end
  end

  def input_for_table_edit(field)
    css = String.new
    css += ' has-error' if field.errors.present?
    @template.content_tag(:div, class: css) do
      field_for_table_view(field)
    end
  end

  def field_for_table_view(field)
    field.read_only? ? @template.content_tag(:div, field.pretty_value, class: 'form-control-static') : field.render_in_table
  end
end

RailsAdmin::Config::Fields::Base.class_eval do
  def render_in_table
    bindings[:view].render partial: "rails_admin/main/in_table/#{partial}", locals: {field: self, form: bindings[:form]}
  rescue StandardError
    render
  end
end
