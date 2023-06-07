view: advanced_modular_navigation_base {
  extension: required

  ########################################
  ###### Fields *requiring override* in extension
  ########################################

  dimension: dashBindings {
    hidden: yes
    type: string
    sql: '131|Dashboard 1||132|Dashboard 2' ;;
  }

  dimension: filterBindings {
    hidden: yes
    type: string
    sql: 'filter1|Filter 1 Name||filter2|Filter 2 Name' ;;
  }


  ########################################
  ###### Fields *optionally overriden* in extension
  ########################################

  dimension: navBarTemplate {
    hidden: yes
    description: "
      This defines the HTML structure for the navbar links to render into.
      Available Tokens: {[[navItems]]: will render the navbar links}
    "
    type: string
    sql:
      CONCAT(
          '<center>'
        ,   '<div style="border-radius: 5px; padding: 5px 10px; height: 60px; background: #F5F5F5;">'
        ,     '<span style="font-size: 18px; display: table; margin:0 auto;">'
        ,       '<img style="float: left; height: 40px;" src="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"/>'
        ,       '[[navItems]]'
        ,     '</span>'
        ,   '</div>'
        , '</center>'
      )
    ;;
  }

  dimension: currentLinkTemplate {
    hidden: yes
    description: "
      This defines the visual representation that the current dashboard link should take.
      Available Tokens: {[[dashName]]: will render the dash name into the html}
    "
    type: string
    sql:
      '<span style="color: #0059D6; padding: 5px 15px; float: left; line-height: 40px; font-weight: bold;">[[dashName]]</span>'
    ;;
  }

  dimension: linkTemplate {
    hidden: yes
    description: "
      This defines the visual representation that other dashboard links should take.
      Available Tokens: {[[dashName]]: will render the dash name into the html, [[dashUrl]]: writes url - pretty much always into an href}
    "
    type: string
    sql:
      '<a style="color: #0059D6; padding: 5px 15px; float: left; line-height: 40px;" href="[[dashUrl]]">[[dashName]]</a>'
    ;;
  }

  dimension: itemDelimiter {
    hidden: yes
    description: "This is the delimiter string used to split bindings items."
    type: string
    sql: '||' ;;
  }

  dimension: valueDelimiter {
    hidden: yes
    description: "This is the delimiter string used to individual bindings into name and value."
    type: string
    sql: '|' ;;
  }


  ########################################
  ###### All overrideable fields
  ########################################
  # dashBindings
  # filterBindings
  # navBarTemplate
  # currentLinkTemplate
  # linkTemplate
  # itemDelimiter
  # valueDelimiter




  # ** override hidden and label in extension as required **
  # ** Add more as required, currently supports 10 filters **
  filter: filter1 { hidden: yes label: "filter1" }
  filter: filter2 { hidden: yes label: "filter2" }
  filter: filter3 { hidden: yes label: "filter3" }
  filter: filter4 { hidden: yes label: "filter4" }
  filter: filter5 { hidden: yes label: "filter5" }
  filter: filter6 { hidden: yes label: "filter6" }
  filter: filter7 { hidden: yes label: "filter7" }
  filter: filter8 { hidden: yes label: "filter8" }
  filter: filter9 { hidden: yes label: "filter9" }
  filter: filter10 { hidden: yes label: "filter10" }


  ########################################
  ###### Navbar definition
  ########################################

  dimension: liquid_navigation_bar {
    type: string
    sql: '' ;;
    html:
      <!-- ********************************************************* -->
      <!-- ******************* build queryString ******************* -->
      <!-- ********************************************************* -->
      {% assign queryString = "" %}

      <!-- loop through filterItems -->
      {% assign filterItems = filterBindings._value | split: itemDelimiter._value %}
      {% for filterItem in filterItems %}

      <!-- split filter into parts -->
        {% assign filterParts = filterItem | split: valueDelimiter._value %}
        {% assign filterField = filterParts[0] %} <!-- for readability -->
        {% assign filterName = filterParts[1] %} <!-- for readability -->

        <!-- case on filter, because we can't mix value interpolation into logic evaluation -->
        <!-- for example, this will not work: {% assign filterValue = _filters['{{ filter }}'] %} -->
        <!-- can't use capture as its not supported in liquid in Looker https://shopify.github.io/liquid/tags/variable/#capture -->
        <!-- ** Add more cases for more filters ** -->
        {% case filterField %}
          {% when "filter1" %}
            {% assign filterValue = _filters['filter1'] %}
          {% when "filter2" %}
            {% assign filterValue = _filters['filter2'] %}
          {% when "filter3" %}
            {% assign filterValue = _filters['filter3'] %}
          {% when "filter4" %}
            {% assign filterValue = _filters['filter4'] %}
          {% when "filter5" %}
            {% assign filterValue = _filters['filter5'] %}
          {% when "filter6" %}
            {% assign filterValue = _filters['filter6'] %}
          {% when "filter7" %}
            {% assign filterValue = _filters['filter7'] %}
          {% when "filter8" %}
            {% assign filterValue = _filters['filter8'] %}
          {% when "filter9" %}
            {% assign filterValue = _filters['filter9'] %}
          {% when "filter10" %}
            {% assign filterValue = _filters['filter10'] %}
          {% else %}
            {% assign filterValue = "out of range filter" %}
            <!-- if you see this value, you've added more filters than supported in filterBindings -->
        {% endcase %}

        <!-- create individual filterString & add to end of queryString -->
        {% assign filterString = filterName | append: "=" | append: filterValue %}
        {% assign queryString = queryString | append: filterString | append: '&' %}
      {% endfor %}



      <!-- ********************************************************* -->
      <!-- ******************* build navItemsHtml ****************** -->
      <!-- ********************************************************* -->
      {% assign navItemsHtml = "" %}

      <!-- loop through filterItems -->
      {% assign navItems = dashBindings._value | split: itemDelimiter._value %}
      {% for navItem in navItems %}

        {% assign navParts = navItem | split: valueDelimiter._value %}
        {% assign dashName = navParts[1] %}
        {% assign dashUrl = "/dashboards/" | append: navParts[0] %}

        <!-- build link -->
        {% if _explore._dashboard_url == dashUrl %}

          <!-- handle dashName token -->
          {% assign currentLinkTemplateParts = currentLinkTemplate._value | split: "[[dashName]]" %}
          {% assign tempString1 = "" %}
          {% assign tempString1 = tempString1 | append: currentLinkTemplateParts[0] %}
          {% assign tempString1 = tempString1 | append: dashName %}
          {% assign tempString1 = tempString1 | append: currentLinkTemplateParts[1] %}

          <!-- add link to navItemsHtml -->
          {% assign navItemsHtml = navItemsHtml | append: tempString1 %}

        {% else %}

          <!-- handle dashName token -->
          {% assign linkTemplateParts = linkTemplate._value | split: "[[dashName]]" %}
          {% assign tempString1 = "" %}
          {% assign tempString1 = tempString1 | append: linkTemplateParts[0] %}
          {% assign tempString1 = tempString1 | append: dashName %}
          {% assign tempString1 = tempString1 | append: linkTemplateParts[1] %}

          <!-- handle dashUrl token -->
          {% assign linkTemplateParts = tempString1 | split: "[[dashUrl]]" %}
          {% assign tempString2 = "" %}
          {% assign tempString2 = tempString2 | append: linkTemplateParts[0] %}
          {% assign tempString2 = tempString2 | append: dashUrl %}
          {% assign tempString2 = tempString2 | append: linkTemplateParts[1] %}

          <!-- add link to navItemsHtml -->
          {% assign navItemsHtml = navItemsHtml | append: tempString2 %}

        {% endif %}
      {% endfor %}



      <!-- ********************************************************* -->
      <!-- ******************* Assemble Navbar ********************* -->
      <!-- ********************************************************* -->
      {% assign navBarTemplateParts = navBarTemplate._value | split: "[[navItems]]" %}
      {% assign finalNavbarHtml = "" %}
      {% assign finalNavbarHtml = finalNavbarHtml | append: navBarTemplateParts[0] %}
      {% assign finalNavbarHtml = finalNavbarHtml | append: navItemsHtml %}
      {% assign finalNavbarHtml = finalNavbarHtml | append: navBarTemplateParts[1] %}

      {{ finalNavbarHtml }}


      <!-- NOTE: There's a bug in _explore._dashboard_url liquid implementation https://buganizer.corp.google.com/issues/281606368 -->
      <center>
        <div>
          <span style="font-size: 10px;">{{ _explore._dashboard_url }} - clear cache & refresh (bug 281606368)</span>
        </div>
      </center>
    ;;
  }

}
