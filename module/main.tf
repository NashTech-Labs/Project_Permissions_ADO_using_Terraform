resource "azuredevops_project" "example" {
  name               = var.project_name_VV
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Managed by Terraform"
}

data "azuredevops_group" "example-readers" {
  project_id = azuredevops_project.example.id
  name       = "Readers"
}

resource "azuredevops_project_permissions" "example-permission" {
  project_id = azuredevops_project.example.id
  principal  = data.azuredevops_group.example-readers.id

  permissions = {
    DELETE              = "Deny"
    EDIT_BUILD_STATUS   = "NotSet"
    WORK_ITEM_MOVE      = "Allow"
    DELETE_TEST_RESULTS = "Deny"
  }
}
