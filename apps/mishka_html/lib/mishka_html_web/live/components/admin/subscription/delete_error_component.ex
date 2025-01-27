defmodule MishkaHtmlWeb.Admin.Subscription.DeleteErrorComponent do
  use MishkaHtmlWeb, :live_component


  def render(assigns) do
    ~H"""
      <div class="error-card-modal col">
        <div class="alert alert-danger vazir rtl" role="alert">
        <div class="col-sm-6 svg-div-error-modal">
          <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-exclamation-triangle-fill flex-shrink-0 me-2" viewBox="0 0 16 16" role="img" aria-label="Warning:">
            <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
          </svg>
        </div>
        <div class="clearfix"></div>
        <div class="col space30"> </div>
        <span class="error-card-modal-main-text">
        <%= MishkaTranslator.Gettext.dgettext("html_live_component", "متاسفانه شما امکان حذف این اشتراک را ندارید. به احتمال زیاد از این شناسه در جاهای دیگر سیستم استفاده شده است.") %>
        </span>

        <div class="clearfix"></div>
        <div class="col space30"> </div>
        <div class="alert alert-warning d-flex align-items-center" role="alert">
          <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:"><use xlink:href="#exclamation-triangle-fill"/></svg>
          <div>
          <%= MishkaTranslator.Gettext.dgettext("html_live_component", "در نسخه بعدی برای حذف سیستمی کاربر امکان حذف کامل اشتراک نیز در سیستم پیاده سازی می شود. به همین ترتیب فعلن فقط می توانید اشتراک را غیر فعال کنید.") %>
          </div>
        </div>
        <div class="col space30"> </div>
        <div class="modal-close-btn">
          <button type="button" class="btn btn-danger" phx-click="close_modal"><%= MishkaTranslator.Gettext.dgettext("html_live_component", "بستن") %></button>
        </div>
        </div>
      </div>
    """
  end
end
