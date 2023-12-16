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
        core -.-> core/commons([/commons])
        core -.-> core/flavors([/flavors])
        core -.-> core/networking([/networking])
        core -.-> core/storage([/storage])
        core -.-> core/theming([/theming])

        subgraph ANALYTICS [&nbsp]
            style ANALYTICS fill:#FFFFF0,stroke-dasharray: 10 5;

            core/analytics -.-> analytics/failure[failure]
            core/analytics -.-> analytics/observers[observers]
            core/analytics -.-> analytics/logger
            analytics/observers -.-o |listens| analytics/failure
            analytics/observers -.-o |notifys| analytics/logger[logger]
            core/analytics -.-> analytics/analytics[analytics]
            analytics/analytics -.-o |notifys| sentry[(sentry)]
        end

        subgraph COMMONS [&nbsp]
            style COMMONS fill:#FFFFF0,stroke-dasharray: 10 5;

            core/commons -.-> commons/extensions[extensions]
            core/commons -.-> commons/utils[utils]
            core/commons -.-> commons/widgets[widgets]

            commons/extensions -.-> commons/extensions/color[color]
            commons/extensions -.-> commons/extensions/context[context]
            commons/extensions -.-> commons/extensions/string[string]
            commons/extensions -.-> commons/extensions/text_style[text_style]

            commons/utils -.-> commons/utils/aliases[aliases]
            commons/utils -.-> commons/utils/paddings[paddings]
            commons/utils -.-> commons/utils/radiuses[radiuses]
            commons/utils -.-> commons/utils/timings[timings]

            commons/widgets -.-> commons/widgets/avatar_image[avatar_image]
            commons/widgets -.-> commons/widgets/blend_mask[blend_mask]
            commons/widgets -.-> commons/widgets/my_platform[my_platform]
            commons/widgets -.-> commons/widgets/nil[nil]
            commons/widgets -.-> commons/widgets/shimmer_effect[shimmer_effect]
        end

        subgraph FLAVORS [&nbsp]
            style FLAVORS fill:#FFFFF0,stroke-dasharray: 10 5;

            core/flavors -.-> flavors/env_dev[env_dev]
            core/flavors -.-> flavors/env_prod[env_prod]
        end

        subgraph NETWORKING [&nbsp]
            style NETWORKING fill:#FFFFF0,stroke-dasharray: 10 5;

            core/networking -.-> networking/client[client]
            core/networking -.-> networking/o_auth2_token[o_auth2_token]
            networking/client -.-> |uses| networking/o_auth2_token
            networking/client -.-> |uses| networking/exceptions[exceptions]
            networking/client -.-> |uses| networking/interceptors[interceptors]
        end

        subgraph STORAGE [&nbsp]
            style STORAGE fill:#FFFFF0,stroke-dasharray: 10 5;

            core/storage -.-> storage/caches[caches]
            core/storage -.-> storage/storages[storages]
            storage/caches -.-> storage/caches/in_memory_cache[in_memory_cache]
            storage/storages -.-> storage/storages/in_memory_token_storage[in_memory_token_storage]
            storage/storages -.-> storage/storages/secure_token_storage[secure_token_storage]
        end

        subgraph THEMING [&nbsp]
            style THEMING fill:#FFFFF0,stroke-dasharray: 10 5;

            core/theming -.-> theming/theme.bloc[theme.bloc]
            theming/theme.bloc -.-> |uses| theming/custom_theme.model[custom_theme.model]
        end
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

        app --o |uses & listens| deps{{/deps}}
        app/router -.- |imports| deps/features([/features])

        design --> |uses| deps
        core --> |uses| deps
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