# this was built using a bq connection, but should be dialect agnostic
connection: "looker-private-demo"

label: "JC Persistent Navbar Demo"

include: "/views/*.view.lkml"
include: "/base_views/*.view.lkml"


view: navbar1 {
  extends: [advanced_modular_navigation_base]

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

view: navbar2 {
  extends: [advanced_modular_navigation_base]

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

  dimension: navBarTemplate {
    hidden: yes
    type: string
    sql:
      CONCAT(
        '<center>'
        ,   '<div style="border-radius: 10px; padding: 10px 10px; height: 60px; background: #EEEEEE;">'
        ,     '<span style="font-size: 18px; display: table; margin:0 auto;">'
        ,       '<img style="float: left; height: 50px;" src="https://lh3.googleusercontent.com/WZZW8egBznCpFPKboxMmcMfElahmhpHs59xdCK6vq_NOCE6p9SuZu9VEuivUqTYBjXugN9_5BIE95VzQ76rl9kYQVhKDheu5afEb"/>'
        ,       '[[navItems]]'
        ,     '</span>'
        ,   '</div>'
        , '</center>'
      )
    ;;
  }

  dimension: currentLinkTemplate {
    hidden: yes
    type: string
    sql:
      '<span style="font-family: cursive; color: #9325B7; padding: 5px 15px; float: left; line-height: 40px; font-weight: bold;">[[dashName]]</span>'
    ;;
  }

  dimension: linkTemplate {
    hidden: yes
    type: string
    sql:
      '<a style="font-family: cursive; color: #C23EED; padding: 5px 15px; float: left; line-height: 40px;" href="[[dashUrl]]">[[dashName]]</a>'
    ;;
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

  join: navbar1 {}
  join: navbar2 {}
}
