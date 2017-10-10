SparkleFormation.new(:cloudfront).load(:base, :git_rev_outputs).overrides do
  description <<EOF
CloudFront distribution pointing to static.#{ENV['public_domain']}.  CNAME record for assets.#{ENV['public_domain']}.
EOF

  dynamic!(:cloudfront_distribution, 'assets', 
           :origin => "static.#{ENV['public_domain']}",
           :ssl_certificate_id => registry!(:my_acm_server_certificate)
           )

  dynamic!(:record_set, 'assets',
           :type => 'CNAME',
           :record => 'assets',
           :target => 'AssetsCloudFrontDistribution',
           :domain_name => ENV['public_domain'],
           :attr => 'DomainName',
           :ttl => 60)
end
