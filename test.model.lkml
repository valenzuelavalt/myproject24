connection: "snowlooker"

include: "/views/billion_orders.view.lkml"
include: "/views/users.view.lkml"
include: "/views/orders.view.lkml"

explore: billion_orders {

  join: users {
    type: left_outer
    sql_on: ${billion_orders.customer_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
