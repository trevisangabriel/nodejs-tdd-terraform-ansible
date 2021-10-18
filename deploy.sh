cd itau-tdd-lab
npm install
npm run test

cd ../terraform
~/terraform/terraform init
~/terraform/terraform validate
~/terraform/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo $"[ec2-nodejs]" > ../ansible/hosts # cria arquivo
echo "$(~/terraform/terraform output | awk '{print $3;exit}')" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 10 # 20 segundos

cd ../ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/Desktop/devops/treinamentoItau

cd ../terraform

open "http://$(~/terraform/terraform output | awk '{print $3;exit}' | sed -e "s/\"//g")"

# *** verifica se aplicação está de pé
# sudo lsof -iTCP -sTCP:LISTEN -P | grep :3000

