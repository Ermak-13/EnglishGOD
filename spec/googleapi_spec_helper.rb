module GoogleApi
  RESPONSE_TEMPLATE = <<-EOF
{
  "sentences":[
    {"trans":"%{trans}","orig":"%{orig}","translit":"%{translit}","src_translit":""}
  ],
  "dict":[
    {
      "pos":"noun","terms":["%{trans}"],
      "entry":[
        {"%{trans}":"%{orig}","reverse_translation":["%{orig}"],"score":0.58786964}
      ],
      "base_form":"%{orig}","pos_enum":1
    }
  ],"src":"en","server_time":65
}
EOF

  def self.response(context)
    JSON.parse(RESPONSE_TEMPLATE % context)
  end
end
