<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/df98db20-65d7-495e-bb20-461557771fd8" />



## AWS | BTCPAY Platform
BTCPay Server creates invoices, presents checkout to customers, and records payments sent directly to wallets controlled by the merchant. It does not hold funds as a payment intermediary.




🎯 Architecture Overview
```
🔐 Security vulnerabilities — insecure code that attackers could exploit
🐛 Bugs — code likely to cause runtime problems
🧹 Code smells — code that is difficult to maintain or unnecessarily complex
📋 Duplicated code
🧪 Test coverage — how much code is covered by tests
📐 Code quality — maintainability and reliability
🔎 Security Hotspots — code that requires security review
```


🧱 Features
```
✔ Fully automated provisioning with Terraform
✔ High availability using multiple subnets in different Availability Zones
✔ Secure connectivity between Application and RDS
✔ Configurable environment variables for database credentials
✔ Easy to extend for other JSON data source
```



🚀 Deployment Options
```
terraform init
terraform validate
terraform plan -var-file="template.tfvars"
terraform apply -var-file="template.tfvars" -auto-approve
```

