class SyncsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_modified_after_date

  def regions
    @regions = Region.all
    if (@modified_after_date != nil)
      @regions = @regions.updated_after_filter(@modified_after_date)
    end
  end

  def ads
    @ads = Ad.includes([:photos, :external_links])
    if (params[:region_id].present?)
      id = params[:region_id]
      @ads = @ads.where('region_id = ?', id)
    else
      @ads = @ads.where('region_id IS NULL')
    end

    if (@modified_after_date != nil)
      @ads = @ads.updated_after_filter(@modified_after_date)
    end
  end

  def contacts
    #TODO: performance, trocar a ordem dessas duas queries
    if (params[:region_id].present?)
      id = params[:region_id]
      @contacts = Contact.includes([:phones, :photos, :external_links, :contact_types]).where('region_id = ?', id).with_deleted
    end

    if (@modified_after_date != nil)
      if @contacts.present?
        @contacts = @contacts.updated_after_filter(@modified_after_date)
      end
    end

    @contacts.each do |contact|
      if contact.search_field.presence
        contact.search_field = remove_special_chars(contact.search_field)
      end
    end

  end

  private
  def remove_special_chars(str)
    str.tr("ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž","AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz").gsub(/[^a-zA-Z0-9 ]/, "")
  end

  def set_modified_after_date
    @modified_after_date = nil
    if (params[:modified_after_date].present?)
      @modified_after_date = params[:modified_after_date]
    end
  end

end
