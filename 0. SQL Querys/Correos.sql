
--crear un perfil de correo en la base de datos

execute msdb.dbo.sysmail_add_profile_sp

@profile_name='GmailP',

@description='Este perfil es utilizado para mandar notificaciones utilizando Gmail'



--dar acceso a los usuarios a este perfil de correo

execute msdb.dbo.sysmail_add_principalprofile_sp

	@profile_name='GmailP',

	@principal_name='public',

	@is_default=1



	--crear una cuenta de correo en la base de datos

execute msdb.dbo.sysmail_add_account_sp

	@account_name='GmailP',

	@description='diegodbh95@gmail.com',

	@email_address='diegodbh95@gmail.com',

	@display_name='Notificaciones Desarrollo',

	@mailserver_name='smtp.gmail.com',

	@port=587,

	@enable_ssl=1,

	@username='diegodbh95@gmail.com',

	@password='236695Ddbh*'



	--agregar la cuenta al perfil Notificaciones

execute msdb.dbo.sysmail_add_profileaccount_sp

	@profile_name='GmailP',

	@account_name='GmailP',

	@sequence_number=1



	select *

from msdb.dbo.sysmail_profile p 

join msdb.dbo.sysmail_profileaccount pa on p.profile_id = pa.profile_id 

join msdb.dbo.sysmail_account a on pa.account_id = a.account_id 

join msdb.dbo.sysmail_server s on a.account_id = s.account_id




declare @BODY varchar(max);

set @BODY='<!DOCTYPE html>

                <html lang="en">

                <head>

                <meta charset="UTF-8">

                    <meta name="viewport" content="width=device-width", initial-scale=1.0">

                </head>

                <body>

                <center><img src="https://yt3.ggpht.com/ytc/AKedOLSB2xSNTvOk4Ked_okQZFGL2UR2RGiacPciEqTI6Q=s900-c-k-c0x00ffffff-no-rj" alt="" width="500" height="500"></center>

		<h3>Correo Mandado desde un vídeo de Borjascript</h3>

                </body>

                </html>';



	Exec msdb.dbo.sp_send_dbmail

		@profile_name='Diego',

		@recipients='data.claro@covisian.com',

		--@copy_recipients='correo1@hotmail.com; correo2@outlook.com',

		@body='Su Job se a ejecutado correctacmente',

		@body_format='HTML',

		@subject='Prueba Correo Sql'