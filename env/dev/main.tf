#Airflow#
module "airflow" {
  source         = "../modules"
  region         = var.region
  zone           = var.zone
  application    = "airflow"
  instance-type  = "t2.micro"
  environment    = var.environment
  volume-type    = "standard"
  image-id       = var.image
  image_name     = "ubuntu"
  add-disk-size  = 10
  boot-disk-size = 10
  public-key     = data.template_file.ssh-airflow-pub.rendered
  private-key    = data.template_file.ssh-airflow-priv.rendered
  myip           = "49.37.128.45/32" #"192.168.29.40/32"
  security-group = var.security-group
  user           = var.user
  #source_script   =  "../scripts/airflow-init.sh"
  #destination_loc = "/tmp/airflow-init.sh"
  init-script = "${base64encode(data.template_file.airflow-script.rendered)}"
  #"${base64encode(data.template_file.test.rendered)}"
}

#Jenkins
module "jenkins" {
  source         = "../modules"
  region         = var.region
  zone           = var.zone
  application    = "Jenkins"
  instance-type  = "t2.micro"
  environment    = var.environment
  volume-type    = "standard"
  image-id       = var.image
  image_name     = "ubuntu"
  add-disk-size  = 10
  boot-disk-size = 10
  public-key     = data.template_file.ssh-airflow-pub.rendered
  private-key    = data.template_file.ssh-airflow-priv.rendered
  myip           = "49.37.128.45/32" #"192.168.29.40/32"
  security-group = var.security-group
  user           = var.user
  #source_script   =  "../scripts/airflow-init.sh"
  #destination_loc = "/tmp/airflow-init.sh"
  init-script = "${base64encode(data.template_file.jenkins-script.rendered)}"
  #"${base64encode(data.template_file.test.rendered)}"
}
