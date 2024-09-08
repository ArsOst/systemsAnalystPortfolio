workspace {
    # !identifiers hierarchical

    model {
        u = person "User" "Searchs, buys goods, monitors order in the store"
        a = person "Administrator" "Sees orders, can edit goods"

        ss_app = softwareSystem "Online electronics store" "Allow customer to view and order electronics goods"{
            cr_front = container "Front Server" "Provides all of the information store functionality to customer via their web browser "
            cr_back = container "Back Server" "Provides all the store functionality bvia a JSON/HTTPS API" {
                ct_gateway = component "GatewayAPI service" "Takes and manages all https requests to microservices"
                ct_auth = component "Auth service" "Allows user to sign in and register to the store"
                ct_goods = component "Goods service" "Allows user to watch and filters goods"
                ct_basket = component "Basket service" "Allows user to watch and manage goods in its backet"
                ct_payment = component "Payment service" "Allows user to pay for goods in basket"
                ct_delivery = component "Delivery service" "Allows user to choise and order delivery of order. And monitor status after it"
                ct_notification = component "Notification service" "Notify user about any important information"
            }
            db = container "Database" {
                tags "database" "Stores user informatioan, goods, baket ect. information "
            }

        }

        group "Our services" {
            sscrm = softwareSystem "CRM system" "Store information about user" {
                tags "inserv tag"
            }

            sswms = softwareSystem "WMS system" "Store information about goods"{
                tags "inserv tag"
            }
        }

        group "Outside services" {

            ssauth = softwareSystem "OpenID Provider" "Sends an identity token and an access token to the store app " {
                tags "outserv tag"
            }

            sspay = softwareSystem "Payment Service" "allows the store to accept electronic payments from a customer"{
                tags "outserv tag"
            }

            ssdel = softwareSystem "Delivery Service" ""Allows the store to send goods to a customer{
                tags "outserv tag"
            }

            ssemail = softwareSystem "Email Service" "Allows the store to send email to a customer" {
                tags "outserv tag"
            }
        }



        u -> ss_app "Browses, buys, tracks electronics products using"
        u -> cr_front "visits https://onlinestore.com/" "HTTPS"
        a -> ss_app "Administrate by "
        a -> cr_front "visits https://onlinestore.com/" "HTTPS"

        cr_front -> ct_gateway "makes API call" "JSON/HTTPS"
        cr_back -> db "read and write to" "TLS, JDBC"
        cr_back -> sscrm "exchanges data" "JSON/HTTPS"
        cr_back -> sswms "exchanges data " "JSON/HTTPS"

        ct_gateway -> ct_auth "JSON/HTTPS"
        ct_gateway -> ct_goods "JSON/HTTPS"
        ct_gateway -> ct_basket "JSON/HTTPS"
        ct_gateway -> ct_payment "JSON/HTTPS"
        ct_gateway -> ct_delivery "JSON/HTTPS"
        ct_gateway -> ct_notification "JSON/HTTPS"
        ct_gateway -> ct_rating "JSON/HTTPS"
        ct_gateway -> ct_loyalty "JSON/HTTPS"

        ct_auth -> db "TLS, SMTP"
        ct_goods -> db "TLS, SMTP"
        ct_basket -> db "TLS, SMTP"
        ct_payment -> db "TLS, SMTP"
        ct_delivery -> db "TLS, SMTP"
        ct_notification -> db "TLS, SMTP"
        ct_rating -> db "TLS, SMTP"
        ct_loyalty -> db "TLS, SMTP"

        ct_auth -> ssauth "get user account informtion and auth to system using" "JSON/HTTPS"
        ct_payment -> sspay "makes payment using" "JSON/HTTPS"
        ct_delivery -> ssdel "order delibery of goods using" "JSON/HTTPS"
        ct_notification -> ssemail "send email by using" "TLS, SMTP"

    }

    views {
        systemContext ss_app "Diagram1" {
            include *

            # autolayout lr
        }

        container ss_app "Diagram2" {
            include *
            # autolayout lr
        }

        component cr_back "Diagram3" {
            include *
            # autolayout lr
        }

        styles {
            element "Element" {
                color white
                shape RoundedBox
            }

            element "Software System" {
                #DarkBlue
                background #00008B
                shape RoundedBox
            }

            element "Container" {
                #Blue
                background #0000FF
            }

            element "Component" {
                #DodgerBlue
                background #1E90FF
            }

            element "Person" {
                background #116611
                shape person
            }

            element "database" {
                shape cylinder
            }

            element "outserv tag" {

                background #A9A9A9
            }

            element "inserv tag" {
                #DarkOliveGreen
                background #556B2F

            }
        }
    }
}
