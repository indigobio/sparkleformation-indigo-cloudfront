SparkleFormation.dynamic(:cloudfront_distribution) do |_name, _config = {}|

  _config[:price_class] ||= 'PriceClass_100' # US only

  parameters("#{_name}_price_class".to_sym) do
    type 'String'
    allowed_values %w(PriceClass_100 PriceClass_200 PriceClass_All)
    default _config[:price_class]
    description 'https://aws.amazon.com/cloudfront/pricing/'
  end

  parameters("#{_name}_comment".to_sym) do
    type 'String'
    default ENV['public_domain']
    allowed_pattern "[\\x20-\\x7E]*"
    description 'Comment to assign to CloudFront distribution, used in search by Chef'
    constraint_description 'can only contain ASCII characters'
  end

  dynamic!(:cloud_front_distribution, _name).properties do
    distribution_config do
      enabled 'true'
      comment ref!("#{_name}_comment".to_sym)
      default_cache_behavior do
        forwarded_values do
          cookies do
            forward 'all'
          end
          query_string 'true'
        end
        target_origin_id _name
        viewer_protocol_policy 'redirect-to-https'
      end
      origins _array(
                ->{
                  if _config.has_key?(:bucket)
                    data![:S3OriginConfig] = {}
                    domain_name attr!(_config[:bucket], :domain_name)
                  else
                    custom_origin_config do
                      data![:HTTPPort] = '80'
                      data![:HTTPSPort] = '443'
                      origin_protocol_policy 'match-viewer'
                    end
                    domain_name _config.fetch(:origin, '{}')
                  end
                  id _name
                }
              )
      price_class ref!("#{_name}_price_class".to_sym)
    end
  end

  outputs do
    domain_name do
      value attr!("#{_name}_cloud_front_distribution".to_sym, :domain_name)
    end
    id do
      value ref!("#{_name}_cloud_front_distribution".to_sym)
    end
  end
end