# Generated by Django 3.2.4 on 2021-06-26 10:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0016_alter_ordermodel_delivered_at'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ordermodel',
            name='delivered_at',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
