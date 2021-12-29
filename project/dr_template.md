# Infrastructure

## AWS Zones
**us-west-1, us-east-2**

## Servers and Clusters

### Table 1.1 Summary
| Asset                            | Purpose                                              | Size                                                        | Qty | DR                                                              |
|----------------------------------|------------------------------------------------------|-------------------------------------------------------------|-----|-----------------------------------------------------------------|
| EC2 Instances                    | To run application code                              | t3.micro(if applicable, not all assets will have same size) | 4   | 2 instances in each AZ.                                         |
| ECR(elastic container registery) | to store custom images                               | Default                                                     | 2   | 1 ECR repo in each AZ                                           |
| Load Balancer Cluster                   | distribute the load on application servers           | Default                                                     | 6   | 3 in each zone                                                  |
| Kubernetes Nodes               | Will install the monitoring stack and other services | t3.micro(if applicable, not all assets will have same size) | 6   | 3 in each zone                                                  |
| Monitoring stack                 | Will install prometheus and grafana                  | default                                                     | 2   | 1 in each zone                                                  |
| RDS Cluster                      | to keep our application data                         | t3.micro(if applicable, not all assets will have same size) | 2   | 1 in each zone, will make primary and secondary                 |
| S3                               | to keep terraform state and rds backup               | default                                                     | 4   | 2 for primary data store, 2 for backup of these primary buckets |
| Github Repo                      | to store application and terraform code              | t3.micro(if applicable, not all assets will have same size) | 2   | 1 in each zone                                                  |


### Descriptions
More detailed descriptions of each asset identified above.
- **EC2 Instances**: These instances will be used for running our application code. 
- **ECR(elastic container registery)**: It will be used for storing the docker images related to our application and will be used in *kubernetes cluster*.
- **Load Balancer**: Load balancers will be used to distribute the load on application servers.
- **Kubernetes Cluster**: Kubernetes cluster will be used for running the application and the monitoring stack in containerized form(pods).
- **Monitoring stack**: This will monitor application servers and will be used get the system matrix.
- **RDS Cluster**:  will be used to store our application data.
- **S3**: These buckets will be used for storing the backups of db's and to store the state of our terraform code.
- **Github Repo**: It will be used to store the application code as well as the terraform code to spin up infrastructure.
## DR Plan
### Pre-Steps:
- Create a bucket in each region to store the terraform state.
- Make necessary changes in the terraform code.
- Will use terraform to spin up infrastructure similar to zone1 to zone2.


## Steps:
- Create application load balancers cluster. This way you can have multiple instances behind 1 IP in a region. During a failover scenario, you would fail over the single DNS entry at your DNS provider to point to the DR site. This is much more intelligent than pointing to a single instance of a web server.
- Have a replicated database and perform a failover on the database. While a backup is good and necessary, it is time-consuming to restore from backup. In this DR step, you would have already configured replication and would perform the database failover. Ideally, your application would be using a generic CNAME DNS record and would just connect to the DR instance of the database.
