resource "google_compute_region_network_endpoint_group" "tech_function_ng" {
  name                  = "function-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_function {
    function = var.function_name
  }

  depends_on = [var.function_dependency]
}

resource "google_compute_backend_service" "function_backend" {
  name                  = "function-backend"
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.tech_function_ng.id
  }
}

resource "google_compute_url_map" "lb_url_map" {
  name            = "function-url-map"
  default_service = google_compute_backend_service.function_backend.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "function-http-proxy"
  url_map = google_compute_url_map.lb_url_map.id
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name                  = "function-http-forwarding-rule"
  target                = google_compute_target_http_proxy.http_proxy.id
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.lb_ip.address
}

resource "google_compute_global_address" "lb_ip" {
  name = "lb-ip"
}