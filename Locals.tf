locals {
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}" # nomenclatura recursos recurso-proyecto-entorno-región
}


resource "random_string" "sufijo-s3" {
  length  = 8
  special = false
  upper   = false
}

locals {
  s3-sufix= "${var.tags.project}-${random_string.sufijo-s3.id}"

}

