module CryptKeeper
  module Provider
    class Base
      def dump(value)
        if value.blank? || CryptKeeper.stub_encryption?
          value
        else
          encrypt(value.to_s)
        end
      end

      def load(value)
        self.encryptor.rotate cipher: 'aes-256-cbc' if !self.encryptor.instance_variable_get(:@rotations).map{|x| x.instance_variable_get(:@cipher)}.include?('aes-256-cbc')
        if value.blank? || CryptKeeper.stub_encryption?
          value
        else
          decrypt(value)
        end
      end
    end
  end
end
