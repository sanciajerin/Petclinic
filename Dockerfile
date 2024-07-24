
# Use the official Tomcat base image
FROM tomcat:9.0

# Maintainer of the image
LABEL maintainer="your-email@example.com"

# Copy the WAR file to the webapps directory of Tomcat
COPY ${WORKSPACE}\target\petclinic.war /usr/local/tomcat/webapps/

# Expose the port on which Tomcat runs
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
