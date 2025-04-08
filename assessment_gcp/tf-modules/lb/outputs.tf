output "load_balancer_url" {
  value = "http://${google_compute_global_address.lb_ip.address}"
}