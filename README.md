# RailsAdminTableField
Supplies Rails Admin with view-partial alternative for Nested Attributes relations.
Changes Native Tabs implementation to Table.

# Usage
## Add to Gemfile:
`gem 'rails_admin_table_field', git: 'https://github.com/iSarCasm/rails_admin_table_field'`

## Inside Models
For edit:
```ruby
field :hotel_rooms do
  render do
    bindings[:view].render(
      partial: 'table_edit',
      locals: {
        field: self,
        form: bindings[:form],
        table_headers: ['Amount', 'Room Type', 'Adult', 'Adult supp', 'Child', 'Child supp', 'Infant', 'Infant supp', 'Senior', 'Senior supp'],
        style: 'width: auto;',
        css: 'container',
        links_style: 'some style for links',
        links_css: 'classes for links'
      }
    )
  end
end
```
For view:
```ruby
field :hotel_rooms do
  pretty_value do
    bindings[:view].render(
      partial: 'rails_admin/table_show',
      locals: {
        objects: bindings[:object].hotel_rooms,
        table_headers: ['Amount', 'Room Type', 'Adult', 'Adult supp', 'Child', 'Child supp', 'Infant', 'Infant supp', 'Senior', 'Senior supp'],
        methods: [:amount, :room_type, :adult, :adult_supp, :child, :child_supp, :infant, :infant_supp, :senior, :senior_supp],
        style: 'width: auto;',
        css: 'container',
      }
    )
  end
end
```

## To change field render inside Table
Add file to `app/views/rails_admin/main/in_table/%_PARTIAL_NAME_%`
