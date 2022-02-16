provider "yandex" {
  token     = "AQAAAAAP7091AATuwR9ReM7BF0bxhu3Ff9oXwEc"
  cloud_id  = "b1gh0n7kf5b5nrdf2il4"
  folder_id = "b1gndtk21ufe5qbljq5h"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "CI" {
  name = "gitlab-ci-vm"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = "fd8hjvnsltkcdeqjom1n"
      size     = "50"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9bei7h8inc7venqurqc"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/Users/kingascalon/.ssh/id_rsa.pub")}"
  }
}
