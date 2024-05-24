provider "google" {

    credentials = "path to service account file(maybe json)"
    project = projectid (under which we are going to create this project)
    region = east-us1
}

resource "google_compute_backend_service" "images_backend_services"{

    name= "images-backend-service"
    timeout_sec = 30
    protocol= HTTP
    port_name = "http"
    port = 443
    health_check = default(if required we can create and specify the id of that particular health check)
}

resource "google_compute_backend_service" "path_backend_services"{

    name= ""product-backend-service"
    timeout_sec = 30
    protocol = HTTP
    port_name = "http"
    port= 443
    health_check = default(if required we can create and specify the id of that particular health check)

}

resource "google_compute_url_map" "url_map" {
    name= url_mapping
    default_service = id of the default service (for example if we are passing image vm)

    host_rule ={
        host = [*/[0.0.0.0/0]/*](basically the ip)
        path_matcher = "path_matcher"
    }
} 

path_matcher {
    name = path_matcher_to_match_id
    default_service = id of the default service (for example if we are passing image vm)
}

default_route_action {
    backend_services = id of the default service (for example if we are passing image vm)
}

path_rule {
    paths = ["/images"/]
    service = id of the default service (for example if we are passing image vm)
}

path_rule {
    paths = ["/product"/]
    service = id of the  service (for example if we are passing product vm)
}

resource "google_compute_http_proxy" "target_http_proxy"{

    name = proxy_demo
    url_map = url-map (has already been created will pass the id)

}

resource "google_compute_forwarding_rules" "forwarding_rules_forilb"{

    proxy = id
    port_range = 443
}