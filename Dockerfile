FROM public.ecr.aws/nginx/nginx:alpine

# Clean out any default Nginx website files
RUN rm -rf /usr/share/nginx/html/*

# Copy everything from your repository into the container
COPY . /usr/share/nginx/html/

# FIX: If your website files were inside a subfolder, this moves them to the correct root location
RUN if [ -d "/usr/share/nginx/html/Bike-site" ]; then mv /usr/share/nginx/html/Bike-site/* /usr/share/nginx/html/; fi

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
