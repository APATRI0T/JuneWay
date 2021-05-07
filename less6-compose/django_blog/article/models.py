from django.db import models


class Article(models.Model):
    create_date = models.DateField(auto_now=True)
    title = models.CharField(max_length=100, verbose_name='Название')
    text = models.TextField(verbose_name='Текст')

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = 'Статью'
        verbose_name_plural = 'Статьи'
