flowchart TB

linkStyle default stroke:green,stroke-width:3px;

subgraph APP [<b>APP</b>]
    style APP fill:#F0FFF0;

    main{main} -.-> |calls| app((APP))
    app -.-> |uses| app/router[router]
    app/router -.-> |routes| app/bottom_navigator[bottom_navigator]
end

subgraph FEATURES [<b>FEATURES</b>]
    style FEATURES fill:#E0FFFF;

    subgraph AUTH [<b>AUTH</b>]
        style AUTH fill:#ffffff,stroke-dasharray: 15 5;

        features/auth -.-> features/auth/login.page[login.page]
        features/auth -.-> features/auth/auth.bloc[auth.bloc]
        features/auth/login.page -.-x |manages| features/auth/login.bloc[login.bloc]
        features/auth/login.bloc -.-> |uses| features/auth/auth.service[auth.service]
        features/auth/login.bloc -.-> |uses| features/auth/user.model[user.model]
        features/auth/auth.service -.-> |uses| features/auth/user.model
    end

    subgraph HOME [<b>HOME</b>]
        style HOME fill:#ffffff,stroke-dasharray: 15 5;

        features/home -.-> features/home/home.page[home.page]
    end
end

subgraph INFRASTRUCTURE [<b>INFRASTRUCTURE</b>]
    style INFRASTRUCTURE fill:#FFE4E1;

    subgraph CORE [<b>CORE</b>]
        style CORE fill:#FFFFFF,stroke-dasharray: 15 5;

        core{{/core}} -.-> core/analytics([/analytics])
    end

    subgraph DESIGN [<b>DESIGN</b>]
        style DESIGN fill:#FFFFFF,stroke-dasharray: 15 5;

        design{{/design}} -.-> design/constants[constants]
        design -.-> design/widgets[widgets]

        design/constants -.-> design/constants/assets.gen[assets.gen]
        design/constants -.-> design/constants/fonts.gen[fonts.gen]
        design/constants -.-> design/constants/themes[themes]
    end

    subgraph LOCATOR [<b>LOCATOR</b>]
        style LOCATOR fill:#FFFFFF,stroke-dasharray: 15 5;

        locator{{/locator}} ==> |injects| core
        locator ==> |injects| features/auth
    end

    subgraph DEPS [<b>DEPS</b>]
        style DEPS fill:#FFFFFF,stroke-dasharray: 15 5;

        app --> |uses & listens| deps{{/deps}}
        app/router -.- |imports| deps/features([/features])

        design --> |uses| deps
        core --> |uses| deps
        locator --> |uses| deps
        features/auth --> |uses| deps

        deps/features --> |uses| deps/core
        deps/features --> |uses| deps/design
        deps/features --> |uses| deps/locator
        deps/features --> |uses| deps/packages

        deps -.- |exports| deps/core([/core])
        deps -.- |exports| deps/design([/design])
        deps -.- |exports| deps/features([/features])
        deps -.- |exports| deps/locator([/locator])
        deps -.- |exports| deps/packages([/packages])

        subgraph DEPS/CORE [&nbsp]
            style DEPS/CORE fill:#FFFFF0,stroke-dasharray: 10 5;

            deps/core -.- |imports| core

            deps/core -.-> deps/core/analytics[analytics]
            deps/core -.-> deps/core/commons[commons]
            deps/core -.-> deps/core/flavors[flavors]
            deps/core -.-> deps/core/storage[storage]
            deps/core -.-> deps/core/theming[theming]
            deps/core -.-> deps/core/networking[networking]

            features/auth/login.bloc -.-o |notifys| deps/core/networking
            features/auth/auth.bloc -.-o |listens| deps/core/networking
        end

        subgraph DEPS/DESIGN [&nbsp]
            style DEPS/DESIGN fill:#FFFFF0,stroke-dasharray: 10 5;

            deps/design -.- |imports| design
        end

        subgraph DEPS/FEATURES [&nbsp]
            style DEPS/FEATURES fill:#FFFFF0,stroke-dasharray: 10 5;

            deps/features -.-> deps/features/auth[auth]
            deps/features -.-> deps/features/home[home]

            deps/features/auth -.- |imports| features/auth((AUTH))
            deps/features/home -.- |imports| features/home((HOME))
        end

        subgraph DEPS/LOCATOR [&nbsp]
            style DEPS/LOCATOR fill:#FFFFF0,stroke-dasharray: 10 5;

            deps/locator -.- |imports| locator
        end

        subgraph DEPS/PACKAGES [&nbsp]
            style DEPS/PACKAGES fill:#FFFFF0,stroke-dasharray: 10 5;

            deps/packages
        end
    end
end