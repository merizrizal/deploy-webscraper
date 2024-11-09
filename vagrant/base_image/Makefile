start-vm:
	vagrant up

stop-vm:
	vagrant halt

teardown-vm: stop-vm
	vagrant destroy -f

rebuild-base-image: teardown-vm start-vm
	@sleep 5 && vagrant halt; \
	image_name=base_image_ws; \
	image_path=`(virsh domblklist --domain $$image_name | awk '/vda/{print $$2}')`; \
	echo Found base image path: $$image_path; \
	sudo qemu-img create -f qcow2 -b $$image_path -F qcow2 $$image_name.qcow2; \
	current_user=`(id -u -n)`; \
	sudo chown $$current_user:$$current_user $$image_name.qcow2; \
	image_size=`(qemu-img info --output=json $$image_name.qcow2 | jq -r '."virtual-size"' | awk '{print $$1}')`; \
	echo Image size = $$image_size; \
	image_size_h=`(qemu-img info --output=json $$image_name.qcow2 | jq -r '."virtual-size"' | awk '{s=int($$1)/(1024^3); print (s == int(s)) ? s : int(s)+1 }')`; \
	echo Human readable image size = $$image_size_h GB; \
	sudo ./create_box.sh $$image_name.qcow2 ubuntu_24_base.box Vagrantfile.add $$image_size_h; \
	sudo chown $$current_user:$$current_user ubuntu_24_base.box; \
	vagrant box add ubuntu_24_base.box --force --name ubuntu_24_base; \
	rm ubuntu_24_base.box;
	rm base_image_ws.qcow2;

check-base-image:
	@image=`(vagrant box list | grep ubuntu_24_base)`; \
	if [ -z "$$image" ]; then \
		echo ">>>>> Base image is not found. Run make rebuild-base-image <<<<<"; \
		exit 1; \
	else \
		echo Found $$image; \
	fi;
