FROM public.ecr.aws/nginx/nginx:alpine

# 1. Clean out any default Nginx website files
RUN rm -rf /usr/share/nginx/html/*

# 2. Copy your bike website files into the container
# If your files are in the root of the repo, use this:
COPY . /usr/share/nginx/html/

# NOTE: If your HTML/CSS files are inside a subfolder in git (like 'public' or 'src'), 
# change the line above to point to that folder instead, for example:
# COPY ./your-folder-name/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
