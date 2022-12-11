provider "google" {
  project = "jcqueiroz-devops-iac"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Finance" {
  display_name = "Finance"
  parent       = "organizations/756642058321"
}

resource "google_folder" "SalesForce" {
  display_name = "SalesForce"
  parent       = google_folder.Finance.name
}

resource "google_folder" "dev" {
  display_name = "dev"
  parent       = google_folder.SalesForce.name
}

resource "google_folder" "prod" {
  display_name = "prod"
  parent       = google_folder.SalesForce.name
}

resource "google_project" "jcqueiroz4-salesforce-dev" {
  name       = "SalesForce-Dev"
  project_id = "jcqueiroz4-salesforce-dev"
  folder_id  = google_folder.dev.name
  auto_create_network=false
  billing_account = "011679-77322D-6BBCBE"

}

resource "google_project" "jcqueiroz4-salesforce-prod" {
  name       = "SalesForce-Prod"
  project_id = "jcqueiroz4-salesforce-prod"
  folder_id  = google_folder.prod.name
  auto_create_network=false
  billing_account = "011679-77322D-6BBCBE"

}
