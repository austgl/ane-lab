package com.example.ane.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * AneLabSendMailFREExtension
 * @author http://twitter.com/tokufxug
 */
public class AneLabSendMailMessage {

	private static AneLabSendMailMessage _mail = null;

	private Session _session = null;

	private AneLabSendMailMessage() {

		Properties p = new Properties();
		// SMTP Server Name
		p.put("mail.smtp.host", "smtp.gmail.com");
		// Connected Host
		p.put("mail.host", "smtp.gmail.com");
		// SMTP Server Port
		p.put("mail.smtp.port", "587");
		// smtp auth
		p.put("mail.smtp.auth", "true");
		// STTLS
		p.put("mail.smtp.starttls.enable", "true");

		// Session
		_session = Session.getDefaultInstance(p);
		_session.setDebug(true);
	}

	public static synchronized AneLabSendMailMessage getInstance() {
		if (_mail == null) {
			_mail = new AneLabSendMailMessage();
		}
		return _mail;
	}

	public String send(AneLabGmailAccount account,
			AneLabSendMailObject mail) {

		MimeMessage msg = new MimeMessage(_session);
		String result = null;
		try {
			msg.setSubject(mail.getSubject(), "utf-8");
			msg.setFrom(
					new InternetAddress("ne4air@ane.so"));
			msg.setSender(
					new InternetAddress("ne4air@ane.so"));

			msg.setRecipient(
					Message.RecipientType.TO,
					new InternetAddress(
					mail.getRecipient()));

			msg.setText(mail.getText(), "utf-8");

			Transport tp = _session.getTransport("smtp");
			tp.connect(account.getAccount(),
					account.getPassword());

			tp.sendMessage(msg, msg.getAllRecipients());
		} catch (MessagingException e) {
			result =
					account.getAccount() + "," +
					account.getPassword() + "," +
					mail.getSubject() + "," +
					mail.getRecipient() + "," +
					mail.getText() + "," +
					e.toString();
		} catch (Exception ex) {
			result =
					account.getAccount() + "," +
							account.getPassword() + "," +
							mail.getSubject() + "," +
							mail.getRecipient() + "," +
							mail.getText() + ","
							+ ex.toString();
		}
		return result;
	}
}
