package edu.spring.prj.email;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;

public class EmailSender {
	
	  @Autowired
      protected JavaMailSender  mailSender;
	  
	  private static final Logger logger =
	  			LoggerFactory.getLogger(EmailSender.class);
	  
	  
      public void SendEmail(Email email) throws Exception {
           
          MimeMessage msg = mailSender.createMimeMessage();
          try {
        	  logger.info("before sendSubject()");
              msg.setSubject(email.getSubject());
              logger.info("before setText()");
              msg.setText(email.getContent());
              logger.info("before setRecipients()");
              msg.setRecipients(MimeMessage.RecipientType.TO , InternetAddress.parse(email.getReceiver()));
              logger.info("after setRecipients()");
          }catch(MessagingException e) {
              System.out.println("MessagingException");
              e.printStackTrace();
          }
          
          try {
        	  logger.info(msg.toString());
              mailSender.send(msg);
          }catch(MailException e) {
              System.out.println("MailException¹ß»ý");
              e.printStackTrace();
          }
      }

}
