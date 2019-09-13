variable "name" {
  description = "The name of the dataflow job"
}
variable "max_workers" {
  description = " The number of workers permitted to work on the job. More workers may improve processing speed at additional cost"
}
variable "on_delete" {
  description = "One of drain or cancel. Specifies behavior of deletion during terraform destroy. The default is cancel."
}
variable "zone" {
  description = "The zone in which the created job should run."
}
variable "machine_type" {
  description = "The machine type to use for the job."
}
variable "subnetwork_self_link" {
  description = "The subnetwork self link to which VMs will be assigned."
}
variable "network_self_link" {
  description = "The network self link to which VMs will be assigned."
}
