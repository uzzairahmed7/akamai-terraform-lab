terraform init
terraform import akamai_edge_hostname.waap-akamaiuwebfraud-com-edgekey-net ehn_5055499,ctr_V-3YSNQK2,grp_211815
terraform import akamai_property._2302-ds0a prp_887852,ctr_V-3YSNQK2,grp_211815,LATEST
terraform import akamai_property_activation._2302-ds0a-staging prp_887852:STAGING
terraform import akamai_property_activation._2302-ds0a-production prp_887852:PRODUCTION
