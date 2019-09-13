resource "google_bigquery_dataset" "default" {
  dataset_id                  = "fooeee"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}
resource "google_bigquery_table" "default" {
  dataset_id = "${google_bigquery_dataset.default.dataset_id}"
  table_id   = "bar"

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "data",
    "type": "STRING",
    "mode": "NULLABLE"
   }
]
EOF
}
resource "google_pubsub_topic" "topic" {
  name = "example-topic"

  labels = {
    fooee = "bar"
  }
}
resource "google_cloud_scheduler_job" "job1" {
  name     = "test-job11"
  description = "test job"
  schedule = "* * * * *"
  region = "us-central1"
  pubsub_target {
    topic_name = "${google_pubsub_topic.topic.id}"
    data = "${base64encode("test")}"
  }
}
resource "google_storage_bucket" "image-3234" {
  name     = "image-3234"
  location = "EU"
}
resource "google_dataflow_job" "big_data_job" {
    name = "${var.name}"
    zone = "${var.zone}"
    max_workers = "${var.max_workers}"
    on_delete = "${var.on_delete}"
    template_gcs_path = "gs://dataflow-templates/latest/PubSub_to_BigQuery"
    temp_gcs_location = "gs://upadhey/tmp_dir/"
     parameters = {
        inputTopic : "${google_pubsub_topic.topic.id}",
       outputTableSpec : "lucifer-251906:fooeee.bar"
   }
    machine_type = "${var.machine_type}"
   network               = "${replace(var.network_self_link, "/(.*)/networks/(.*)/", "$2")}"
   subnetwork            = "${replace(var.subnetwork_self_link, "/(.*)/regions/(.*)/", "regions/$2")}"
}
