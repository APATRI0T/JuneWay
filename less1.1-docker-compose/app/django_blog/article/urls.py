
from django.urls import path

from . import views
from .views import ArticleListView, ArticleDetailView, ArticleCreateView

urlpatterns = [

    path('', ArticleListView.as_view(), name='article_list'),
    path('detail/<int:pk>', ArticleDetailView.as_view(), name='detail_list'),
    path('edit-page', views.ArticleCreateView.as_view(), name='edit_page'),
    path('update-page/<int:pk>', views.ArticleUpdateView.as_view(), name='update_page'),
    path('delete-page/<int:pk>', views.ArticleDeleteView.as_view(), name='delete_page'),
    path('login', views.MyProjectLoginView.as_view(), name='login_page'),
    path('register', views.RegisterUserView.as_view(), name='register_page'),
    path('logout', views.MyProjectLogout.as_view(), name='logout_page'),
]