namespace :firebase do
  namespace :certificates do
    desc "Request Google's x509 certificates and override Redis"
    task request: :environment do
      FirebaseIdToken::Certificates.request!
    end
  end
end
