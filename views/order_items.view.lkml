# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.order_items ;;


  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date,day_of_year, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.
  measure: total_sale_price {
    value_format: "$#,##0.00"
    type: sum
    sql: ${sale_price} ;;
    html:
    {% if selector._parameter_value ==  "'dolar'"  %}
       <span>{{ rendered_value }}</span>
    {% elsif  selector._parameter_value ==  "'decimal'" %}
       <span>{{ value | round: 2 }}</span>
    {% endif %} ;;

  }


  parameter: selector {
    type: string
    description: "Used to select the format on visualization"
    allowed_value: {
      label: "decimal"
      value: "decimal"
    }
    allowed_value: {
      label: "dolar"
      value: "dolar"
    }
  }


  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
