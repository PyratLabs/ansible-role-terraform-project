resource "null_resource" "testing" {
    provisioner "local-exec" {
        command = "cat /etc/hostname"
    }
}
