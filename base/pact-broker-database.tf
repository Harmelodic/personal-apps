module "apps_database_pact_broker_database" {
  source                            = "./workload-database"
  database_instance_connection_name = data.google_sql_database_instance.apps.connection_name
  database_instance_name            = data.google_sql_database_instance.apps.name
  namespace                         = module.pact_broker_workload.namespace
  project_id                        = data.google_project.apps.project_id
  workload_service_account_email    = module.pact_broker_workload.google_service_account.email
  workload_name                     = module.pact_broker_workload.name
}
