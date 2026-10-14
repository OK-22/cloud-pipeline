output "public_ip" {
  description = "Public address of the app server"
  value       = aws_instance.app.public_ip
}

output "app_url" {
  description = "URL to open in a browser"
  value       = "http://${aws_instance.app.public_ip}"
}
