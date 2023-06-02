# this was built using a bq connection, but should be dialect agnostic
connection: "looker-private-demo"

label: "JC Persistent Navbar Demo"

include: "/views/*.view.lkml"
include: "/base_views/*.view.lkml"

# include: "/dashboards/*"


view: navbar {
  extends: [modular_navigation_base]

  dimension: dashBindings {
    hidden: yes
    type: string
    sql: '149|Navbar Demo Dash 1||151|Navbar Demo Dash 2' ;;
  }

  dimension: filterBindings {
    hidden: yes
    type: string
    sql: 'filter1|Continent||filter2|Country+Name' ;;
  }

  filter: filter1 {
    hidden: no
    label: "Continent"
  }
  filter: filter2 {
    hidden: no
    label: "Country Name"
  }

}


explore: countries {
  view_name: country_reference

  join: navbar {}
}
