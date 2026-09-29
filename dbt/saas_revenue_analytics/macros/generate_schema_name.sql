{% macro generate_schema_name(custom_schema_name, node) %}

    {# Use the target schema when no custom schema is defined #}
    {% if custom_schema_name is none %}

        {{ target.schema }}

    {# Otherwise, use the custom schema defined in dbt_project.yml #}
    {% else %}

        {{ custom_schema_name | trim }}

    {% endif %}

{% endmacro %}