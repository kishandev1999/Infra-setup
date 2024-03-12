data "template_file" "ssh-airflow-pub" {
  template = file("files/airflow.pub")
}

data "template_file" "ssh-airflow-priv" {
  template = file("files/airflow")
}

data "template_file" "airflow-script" {
  template = file("../scripts/airflow-init.sh")
  # here two dots mentioned is due to moving back to two directories step back
}


data "template_file" "jenkins-script" {
  template = file("../scripts/jenkins-init.sh")
  # here two dots mentioned is due to moving back to two directories step back
}
