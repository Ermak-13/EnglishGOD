class TranslationDecorator < SimpleDelegator
  def value()
    @delegate_sd_obj.value['sentences'][0]['trans']
  end

  def probable_values()
    probable_values = {}
    if @delegate_sd_obj.value['dict']
      @delegate_sd_obj.value['dict'].each do |i|
        probable_values[i['pos']] = i['terms']
      end
    end

    probable_values
  end
end
