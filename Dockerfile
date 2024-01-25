# 1. Using the node image as the base image
FROM node:16-alpine

# 2. Install pnpm globally (you can remove this step if you already installed pnpm locally)
RUN npm install -g pnpm

# 3. Set the working directory inside the container
WORKDIR /usr/src/app

# 4. Copy the package.json and package-lock.json (or pnpm-lock.yaml) to the working directory
COPY package*.json ./

# 5. Install dependencies using pnpm
RUN pnpm install

# 6. Copy the rest of the source code to the container's working directory
COPY . .

# 7. Build your TypeScript code
RUN pnpm build

# 8. Expose the port your application is listening on (if applicable)
EXPOSE 3000

# 9. Set the command to run your application
CMD ["pnpm", "start"]
